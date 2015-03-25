T9n.setLanguage('en');

// Routes
AccountsTemplates.configureRoute('signIn');
AccountsTemplates.configureRoute('signUp');
AccountsTemplates.configureRoute('verifyEmail');
AccountsTemplates.configureRoute('changePwd');
AccountsTemplates.configureRoute('enrollAccount');
AccountsTemplates.configureRoute('forgotPwd');
AccountsTemplates.configureRoute('resetPwd');

// Options
AccountsTemplates.configure({
    // Behaviour
    //confirmPassword: true,
    //defaultState: "signIn",
    enablePasswordChange: true,
    //enforceEmailVerification: false, // better not to use this
    //forbidClientAccountCreation: false,
    //overrideLoginErrors: true,
    //sendVerificationEmail: false,
    //redirectTimeout: 2000,
    //socialLoginStyle: "popup",
    //lowercaseUsername: false,

    // Appearance
    //defaultLayout: undefined,
    //hideSignInLink: false,
    //hideSignUpLink: false,
    //showAddRemoveServices: false,
    showForgotPasswordLink: true,
    //showLabels: true,
    //showPlaceholders: true,

    // Client-side Validation
    continuousValidation: true,
    negativeValidation: true,
    positiveValidation: true,
    negativeFeedback: true,
    positiveFeedback: true,
    showValidating: true,

    // Links
    //homeRoutePath: '/',
    //privacyUrl: undefined,
    //termsUrl: undefined,

    // Hooks
    //onLogoutHook: myLogoutFunc,
    //onSubmitHook: mySubmitFunc,

    // Texts
    texts: {}

});