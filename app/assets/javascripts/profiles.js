// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function previewFileWithId(id) {
    const target = this.event.target;
    const file = target.files[0];
    const reader  = new FileReader();
    reader.onloadend = function () {
        preview.src = reader.result;
    }
    if (file) {
        reader.readAsDataURL(file);
    } else {
        preview.src = '';
    }
}