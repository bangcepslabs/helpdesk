package com.helpdesk.user.profile.controller;

import com.helpdesk.common.util.SessionUtil;
import com.helpdesk.user.auth.service.LoginService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/user/profile")
public class ProfileController {

    @org.springframework.beans.factory.annotation.Autowired
    private LoginService loginService;

    /** 프로필 페이지 */
    @GetMapping("")
    public String profile(HttpServletRequest request, Model model) {
        Map<String, Object> loginUser = SessionUtil.getLoginUser(request);
        
        if (loginUser == null) return "redirect:/auth/login";
        String userId = SessionUtil.getLoginUserId(request);
        Map<String, Object> userStats = loginService.getProfileStats(userId);
        
        model.addAttribute("userStats", userStats);
        model.addAttribute("pageTitle", "내 정보 관리");
        
        return "user/profile";
    }

    /** 비밀번호 변경 (Ajax) */
    @PostMapping("/changePassword")
    @ResponseBody
    public Map<String, Object> changePassword(@RequestParam String currentPassword,
                                              @RequestParam String newPassword,
                                              HttpServletRequest request) {
        
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> loginUser = SessionUtil.getLoginUser(request);
        
        try {
            if (loginUser == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }
            String userId = SessionUtil.getLoginUserId(request);
            if (!loginService.isPasswordValid(userId, currentPassword)) {
                result.put("success", false);
                result.put("message", "현재 비밀번호가 올바르지 않습니다.");
                return result;
            }
            
            // 새 비밀번호 유효성 검사
            if (newPassword.length() < 8) {
                result.put("success", false);
                result.put("message", "새 비밀번호는 8자 이상이어야 합니다.");
                return result;
            }
            
            // 비밀번호 복잡성 검사
            if (!isValidPassword(newPassword)) {
                result.put("success", false);
                result.put("message", "비밀번호는 대소문자, 숫자, 특수문자를 포함해야 합니다.");
                return result;
            }
            
            if (loginService.changePassword(userId, newPassword) <= 0) {
                result.put("success", false);
                result.put("message", "비밀번호 변경 대상 사용자를 찾을 수 없습니다.");
                return result;
            }
            
            result.put("success", true);
            result.put("message", "비밀번호가 성공적으로 변경되었습니다.");
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "비밀번호 변경 중 오류가 발생했습니다.");
        }
        
        return result;
    }
    
    /**
     * 비밀번호 복잡성 검사
     */
    private boolean isValidPassword(String password) {
        // 최소 8자, 대문자, 소문자, 숫자, 특수문자 중 3가지 이상 포함
        int complexity = 0;
        
        if (password.matches(".*[a-z].*")) complexity++;
        if (password.matches(".*[A-Z].*")) complexity++;
        if (password.matches(".*[0-9].*")) complexity++;
        if (password.matches(".*[^a-zA-Z0-9].*")) complexity++;
        
        return complexity >= 3;
    }
}
