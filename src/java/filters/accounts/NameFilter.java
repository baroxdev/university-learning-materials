package filters.accounts;

import entities.User;

public class NameFilter implements AccountFilter {
    private String query;
    private String searchType;

    public NameFilter(String query, String searchType) {
        this.query = query;
        this.searchType = searchType;
    }

    @Override
    public boolean matches(User account) {
        boolean isMatch = false;

        switch (searchType) {
            case "username": {
                isMatch = account.getUsername().contains(query);
                break;
            }
            case "name": {
                isMatch = account.getFullName().contains(query);
                break;
            }
        }

        return isMatch;
    }
}
