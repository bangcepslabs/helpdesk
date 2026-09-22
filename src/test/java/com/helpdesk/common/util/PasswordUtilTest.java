package com.helpdesk.common.util;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class PasswordUtilTest {

    @Test
    void encryptIsDeterministicAndMatchesOnlyOriginalPassword() {
        String encoded = PasswordUtil.encrypt("Helpdesk#2026");

        assertEquals(encoded, PasswordUtil.encrypt("Helpdesk#2026"));
        assertTrue(PasswordUtil.matches("Helpdesk#2026", encoded));
        assertFalse(PasswordUtil.matches("wrong-password", encoded));
        assertEquals(64, encoded.length());
    }
}
