var empSelected = document.getElementById('<%=hiddenFieldEmploye.ClientID%>').value.split(',');

var catSelected = document.getElementById('<%=hiddenFieldCat.ClientID%>').value.split(',');

var projetSelected = document.getElementById('<%=hiddenFieldProjet.ClientID%>').value.split(',');

function UpdateDateFormat() {

    var dateFormated = document.getElementById('<%=dateFormated.ClientID%>')

    if (input.value == "") {
        dateFormated.innerText = "Veuillez sélectionner la date";
        return;
    }

    var format = FormatYear(input.value);

    dateFormated.innerText = format;
}

function FormatYear(yearString) {

    var split = yearString.split('-');

    if (split.length != 3)
        split = yearString.split('/');

    var year = split[0];
    var month = parseInt(split[1]);
    var day = parseInt(split[2]);

    var months = ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"];

    return day + " " + months[month - 1] + " " + year;;
}

//ID du crisse de multi + class du css
$('#empMultiSelect').multiSelect({
    //EVENT inscrit nul part guess Onchange, onSelected pis onclick avec function return click
    afterSelect: function (values) {
        //Parce que D'amours
        empSelected.push(values);
        console.log(empSelected);


        var htmlStorage = document.getElementById('<%=hiddenFieldEmploye.ClientID%>');
        //htmlStorage.attr("data-assessments", JSON.stringify(selected));
        htmlStorage.value = empSelected;

        console.log(htmlStorage);
    },

    afterDeselect: function (values) {
        var copy = [];

        for (var idx in empSelected) {
            if (empSelected[idx][0] != values[0]) {
                copy.push(empSelected[idx])
            }
        }

        empSelected = copy;

        console.log(empSelected);
        var htmlHiddenFieldEmploye = document.getElementById('<%=hiddenFieldEmploye.ClientID%>');

        htmlHiddenFieldEmploye.value = empSelected;
    },

    selectableOptgroup: true,
    keepOrder: true
});

//ID du crisse de multi + class du css
$('#catMultiSelect').multiSelect({
    //EVENT inscrit nul part guess Onchange, onSelected pis onclick avec function return click
    afterSelect: function (values) {
        //Parce que D'amours
        catSelected.push(values);
        console.log("Caegories : " + catSelected);


        var htmlhiddenFieldCat = document.getElementById('<%=hiddenFieldCat.ClientID%>');
        //htmlStorage.attr("data-assessments", JSON.stringify(selected));
        htmlhiddenFieldCat.value = catSelected;

        console.log(htmlhiddenFieldCat);
    },

    afterDeselect: function (values) {
        var copy = [];

        for (var idx in catSelected) {
            if (catSelected[idx][0] != values[0]) {
                copy.push(catSelected[idx])
            }
        }

        catSelected = copy;

        console.log(catSelected);
        var htmlhiddenFieldCat = document.getElementById('<%=hiddenFieldCat.ClientID%>');

        htmlhiddenFieldCat.value = catSelected;
    },

    selectableOptgroup: true,
    keepOrder: true
});

//ID du crisse de multi + class du css
$('#projetMultiSelect').multiSelect({
    //EVENT inscrit nul part guess Onchange, onSelected pis onclick avec function return click
    afterSelect: function (values) {
        //Parce que D'amours
        projetSelected.push(values);
        //console.log("Caegories : " + catSelected);


        var htmlhiddenFieldCat = document.getElementById('<%=hiddenFieldProjet.ClientID%>');
        //htmlStorage.attr("data-assessments", JSON.stringify(selected));
        htmlhiddenFieldCat.value = projetSelected;

        console.log(htmlhiddenFieldCat);
    },

    afterDeselect: function (values) {
        var copy = [];

        for (var idx in projetSelected) {
            if (projetSelected[idx][0] != values[0]) {
                copy.push(projetSelected[idx])
            }
        }

        projetSelected = copy;

        console.log(catSelected);
        var htmlhiddenFieldCat = document.getElementById('<%=hiddenFieldProjet.ClientID%>');

        htmlhiddenFieldCat.value = projetSelected;
    },

    selectableOptgroup: true,
    keepOrder: true
});


