var choiseStudent = true;

if(localStorage.getItem("token") != null){
    window.location.href = "/profile"; // To be added after testing
}

$("#change-student").click(function(){
    if(!choiseStudent){
        choiseStudent = true;
        $("#change-professor").removeClass("active")
        $("#change-professor").addClass("inactive underlineHover");

        $("#change-student").removeClass("inactive underlineHover")
        $("#change-student").addClass("active");

        $("#professor-login").addClass("hidden");
        $("#student-login").removeClass("hidden");
    }
});

$("#change-professor").click(function(){
    if(choiseStudent){
        choiseStudent = false;
        $("#change-student").removeClass("active")
        $("#change-student").addClass("inactive underlineHover");

        $("#change-professor").removeClass("inactive underlineHover")
        $("#change-professor").addClass("active");
        
        $("#student-login").addClass("hidden");
        $("#professor-login").removeClass("hidden");
    }
})


$( "#student-login" ).submit(function( event ){
    event.preventDefault();

    var inputs = $('#student-login :input');

    var values = {};
    inputs.each(function() {
        values[this.name] = $(this).val();
    });

    const credentials = {
        cnp: values.cnp,
        password: values.password
    }


    $.ajax
    ({
        type: "POST",
        url: 'https://localhost:5001/auth/student',
        contentType: 'application/json',
        data: JSON.stringify(credentials),
        success: function (data) {
            localStorage.setItem("token", data.token);
            window.location.href = "/profile";
        },
        error: function (XMLHttpRequest, textStatus, errorThrown){
            alert(XMLHttpRequest.responseJSON.message)
        }
    })
});

$( "#professor-login" ).submit(function( event ){
    event.preventDefault();

    var inputs = $('#professor-login :input');

    var values = {};
    inputs.each(function() {
        values[this.name] = $(this).val();
    });

    const credentials = {
        username: values.username,
        password: values.password
    }


    $.ajax
    ({
        type: "POST",
        url: 'https://localhost:5001/auth/professor',
        contentType: 'application/json',
        data: JSON.stringify(credentials),
        success: function (data) {
            localStorage.setItem("token", data.token);
        },
        error: function (XMLHttpRequest, textStatus, errorThrown){
            alert(XMLHttpRequest.responseJSON.message)
        }
    })
});