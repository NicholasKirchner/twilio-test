wordCount = { "fromName": 0,
              "fromMessage": 0 }

function pluralize_character(number) {
    return number.toString() + (number == 1 ? " character" : " characters")
}

function updateCount() {
    $("#char-name").text(pluralize_character(wordCount["fromName"]));
    $("#char-message").text(pluralize_character(wordCount["fromMessage"]));
    var remaining = 138 - wordCount["fromName"] - wordCount["fromMessage"];
    $("#char-remain").text(pluralize_character(remaining));
}

function parse_csv(event) {
    var fileList = event.target.files;
    if (fileList.length == 0) {
        wordCount["fromName"] = 0;
        return;
    }
    var file = fileList[0];
    var file_reader = new FileReader();

    file_reader.onload = function(e) {
        var contents = e.target.result;
        var lines = contents.split(/[\r\n]+/g);
        var max_len = 0;
        for(var i = 0; i < lines.length; i++) {
            var indexOfComma = lines[i].indexOf(",");
            max_len = Math.max(indexOfComma, max_len);
        }
        wordCount["fromName"] = max_len;
        updateCount();
    };
    file_reader.readAsBinaryString(file);
}

//Put following line in document...ready?
$(document).ready(function() {
    document.getElementById("recipients_file").addEventListener('change', parse_csv, false);
    $("#message_content").keyup(function() {
        wordCount["fromMessage"] = $("#message_content").val().length;
        updateCount();        
    });
});
