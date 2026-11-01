package com.classvoice.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

/** PBKDF2 for new accounts, with verification support for old salted SHA-256 demo hashes. */
public final class PasswordUtil {
    private static final SecureRandom RANDOM = new SecureRandom();
    private static final int ITERATIONS = 210_000;
    private static final int KEY_BITS = 256;
    private static final String FORMAT = "pbkdf2_sha256";

    private PasswordUtil() { }

    public static String hash(String password) {
        byte[] salt = new byte[16];
        RANDOM.nextBytes(salt);
        byte[] result = derive(password, salt, ITERATIONS);
        return FORMAT + "$" + ITERATIONS + "$"
                + Base64.getEncoder().encodeToString(salt) + "$"
                + Base64.getEncoder().encodeToString(result);
    }

    public static boolean matches(String password, String stored) {
        if (password == null || stored == null) return false;
        try {
            if (stored.startsWith(FORMAT + "$")) {
                String[] parts = stored.split("\\$", -1);
                if (parts.length != 4) return false;
                int iterations = Integer.parseInt(parts[1]);
                if (iterations < 100_000 || iterations > 1_000_000) return false;
                byte[] salt = Base64.getDecoder().decode(parts[2]);
                byte[] expected = Base64.getDecoder().decode(parts[3]);
                if (salt.length != 16 || expected.length != 32) return false;
                return MessageDigest.isEqual(expected, derive(password, salt, iterations));
            }
            // Historical ClassVoice accounts (salt:SHA-256(salt || password)).
            if (!stored.contains(":")) return false;
            String[] parts = stored.split(":", 2);
            byte[] salt = Base64.getDecoder().decode(parts[0]);
            byte[] expected = Base64.getDecoder().decode(parts[1]);
            MessageDigest sha = MessageDigest.getInstance("SHA-256");
            sha.update(salt);
            return MessageDigest.isEqual(expected,
                    sha.digest(password.getBytes(StandardCharsets.UTF_8)));
        } catch (Exception ignored) {
            return false;
        }
    }

    private static byte[] derive(String password, byte[] salt, int iterations) {
        PBEKeySpec spec = new PBEKeySpec(password.toCharArray(), salt, iterations, KEY_BITS);
        try {
            return SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256")
                    .generateSecret(spec).getEncoded();
        } catch (Exception ex) {
            throw new IllegalStateException("Password hashing is unavailable", ex);
        } finally {
            spec.clearPassword();
        }
    }
}
