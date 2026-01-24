# Plan: Add User Authentication

**Created:** 2025-01-24
**Status:** Approved

---

## Objective

Implement JWT-based authentication with refresh token support for the REST API.

---

## Approach

1. Create authentication middleware in `src/middleware/auth.ts`
2. Add JWT generation utilities in `src/utils/jwt.ts`
3. Update user model to include refresh tokens
4. Add auth routes for login/logout/refresh
5. Protect existing API routes with auth middleware
6. Write tests for all auth flows

---

## Files to Modify

- `src/models/User.ts:45-67` - Add refreshToken field and methods
- `src/routes/api.ts:12-18` - Apply auth middleware to protected routes
- `package.json:23` - Add jsonwebtoken dependency

## Files to Create

- `src/middleware/auth.ts` - JWT validation middleware
- `src/utils/jwt.ts` - Token generation/validation utilities
- `src/routes/auth.ts` - Auth endpoints (login/logout/refresh)
- `tests/auth.test.ts` - Comprehensive auth tests

---

## Risks & Edge Cases

- **Token expiration during active sessions**: Use refresh tokens with sliding window
- **Concurrent requests with same token**: Rate limit auth endpoints
- **Brute force attacks**: Implement account lockout after N failed attempts
- **Edge cases**: Expired refresh tokens, invalid signatures, missing tokens

---

## Success Criteria

- [ ] Users can log in and receive access + refresh tokens
- [ ] Protected routes reject unauthenticated requests with 401
- [ ] Refresh token flow generates new access token
- [ ] Logout invalidates refresh token
- [ ] All 24 auth tests passing
- [ ] No security vulnerabilities (verified with npm audit)

---

## Notes

Using RS256 instead of HS256 for better key rotation support in production.
Consider adding IP allowlisting for admin routes in follow-up work.
