

//Select single CheckBox
function ListViewSelectRow(sender) {
    var checkBox = document.getElementById(sender);
    if (checkBox.checked) {
        checkBox.checked = false;
    }
    else {
        checkBox.checked = true;
    }
};

function isNumeric(keyCode) {
    return ((keyCode >= 48 && keyCode <= 57) || (keyCode >= 96 && keyCode <= 105) || keyCode == 8 || keyCode == 13 || keyCode == 9 || keyCode == 109 || keyCode == 189)
};
function isDate(keyCode) {
    return ((keyCode >= 48 && keyCode <= 57) || (keyCode >= 96 && keyCode <= 105) || keyCode == 8 || keyCode == 13 || keyCode == 191 || keyCode == 9)
};
function isDecimal(keyCode) {
    return ((keyCode >= 48 && keyCode <= 57) || (keyCode >= 96 && keyCode <= 105) || keyCode == 8 || keyCode == 13 || keyCode == 37 || keyCode == 39 || keyCode == 46 || keyCode == 9)
};
function isAlpha(keyCode) {
    return ((keyCode >= 65 && keyCode <= 90) || keyCode == 8 || keyCode == 13 || keyCode == 9)
};
function isAlphaNumeric(keyCode) {
    return ((keyCode >= 48 && keyCode <= 57) || (keyCode >= 96 && keyCode <= 105) || (keyCode >= 65 && keyCode <= 90) || keyCode == 8 || keyCode == 13 || keyCode == 9 || keyCode == 16 || keyCode == 192)
};
function isAlphaNumericSpace(keyCode) {
    return ((keyCode >= 48 && keyCode <= 57) || (keyCode >= 96 && keyCode <= 105) || (keyCode >= 65 && keyCode <= 90) || keyCode == 8 || keyCode == 13 || keyCode == 32 || keyCode == 189 || keyCode == 9)
};

function CheckDecimal(sender) {
    //Get reference to textbox
    var decimalTextbox = document.getElementById(sender);
    //Get the value of the textbox
    var input = decimalTextbox.value;
    //Get rid of any existing deicmal places
    input = input.replace(".", "");
    //Get the index of the last 2 digits
    var index = input.length - 2;
    //Declare the first part of the new value
    var firstPart = input.substring(0, index);
    //Get the second part of the decimal
    var secondPart = input.substring(firstPart.length);
    //Set the defaults for new value
    if (firstPart.length == 0) {
        firstPart = "0";
    }
    if (secondPart.length == 0) {
        secondPart = "00";
    }
    if (secondPart.length == 1) {
        secondPart = "0" + secondPart;
    }
    //Create the new value with the decimal place
    var newValue = firstPart + '.' + secondPart;
    //Remove trailing zeros
    newValue = parseFloat(newValue).toFixed(2);
    //Pass the value back to the textbox
    $(decimalTextbox).val(newValue);
};

function addCommas(sender) {
    var nuemricTextBox = document.getElementById(sender);
    var input = nuemricTextBox.value;
    input += '';
    x = input.split('.');
    x1 = x[0];
    x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
    x1 = x1.replace(rgx, '$1' + ',' + '$2');
}
var newValue = x1 + x2;
    $(nuemricTextBox).val(newValue);

};

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//Add remove items from showing update progress
var noProgressArray = new Array();
//Check if Array has item already exluded from showing progress
function CheckNoProgressArray(sender) {
    var result = false;
    for (var i = 0; i < noProgressArray.length; i++) {
        if (noProgressArray[i] == sender) {
            result = true;
        }
    }
    return result;
};
