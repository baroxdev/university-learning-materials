package filters.accounts;

import entities.User;

public interface AccountFilter {
    boolean matches(User account);
}
