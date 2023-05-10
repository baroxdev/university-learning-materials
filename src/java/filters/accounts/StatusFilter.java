package filters.accounts;

import entities.User;

public class StatusFilter implements AccountFilter {
    private boolean status;

    public StatusFilter(boolean status) {
        this.status = status;
    }

    @Override
    public boolean matches(User account) {
        return account.getActive().equals(status);
    }
}
