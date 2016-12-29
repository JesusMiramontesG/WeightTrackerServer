function changeElementType(element, newElementType) {
    $(element).attr("type", newElementType);
}

/*
 * begins the UI activity procedure; show "loading" and hide the login button
 */
function toggleAuthActivity() {
    activityIndicator = $("#activity-indicator");
    signInButton = $("#sign-in-btn");
    isAuthenticating = signInButton.hasClass("authenticating");
    if (!isAuthenticating) {
        activityIndicator.addClass("indicator-animating-in");
        signInButton.addClass("btn-auth-animating-out authenticating");
    } else {
        activityIndicator.removeClass("indicator-animating-in");
        signInButton.removeClass("btn-auth-animating-out authenticating");
    }
}

/* toggles the attribute type of the auth password field
 * param element - the element whose type should be toggled
 * returns string containing the name of new attribute type name
 */
function toggleShowPassword(element) {
    attrType = element.attr("type");
    if (attrType == "password") {
        element.attr("type", "text");
        return element.attr("type");
    } else if (attrType == "text") {
        element.attr("type", "password");
        return element.attr("type");
    } else {
        // do nothing
        return;
    }
}

$(document).ready(function() {
    $(".show-password").on("click", function() { 
        passwordField = $("#user_password");
        newType = toggleShowPassword(passwordField);
        anchor = $(this).children("a");
        if (newType == "password") {
            anchor.html("Show");
        } else {
            anchor.html("Mask");
        }
    });

    $("#sign-in-btn").on("click", function() {
        toggleAuthActivity();
    });
});
