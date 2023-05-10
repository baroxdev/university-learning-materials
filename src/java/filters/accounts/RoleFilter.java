package filters.accounts;

import entities.User;

public class RoleFilter implements AccountFilter {
    private String roleID;

    public RoleFilter(String roleID) {
        this.roleID = roleID;
    }

    @Override
    public boolean matches(User account) {
        return account.getRoleID().toLowerCase().equals(roleID.toLowerCase());
    }
}
