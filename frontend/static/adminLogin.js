if(localStorage.getItem("token-admin")){
    window.location.href = "/adminpage"; // To be added after testing
}

$( "#admin-login" ).submit(function( event ){
    event.preventDefault();

    var inputs = $('#admin-login :input');

    var values = {};
    inputs.each(function() {
        values[this.name] = $(this).val();
    });

    const credentials = {
        name: values.username,
        password: values.password
    }

    console.log(credentials);


    $.ajax
    ({
        type: "POST",
        url: 'https://localhost:5001/auth/admin',
        contentType: 'application/json',
        data: JSON.stringify(credentials),
        success: function (data) {
            localStorage.setItem("token-admin", data.token);
            window.location.href = "/adminpage"; 
        },
        error: function (XMLHttpRequest, textStatus, errorThrown){
            alert(XMLHttpRequest.responseJSON.message)
        }
    });
});
