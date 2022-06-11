bool validateEmail(String email) =>
    email != '' &&
    !RegExp(r'\b[a-zA-Z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
        .hasMatch(email);
bool checkPassword(String password) => password.length <= 5;
