//= require jquery3
//= require rails-ujs
//= require admin-lte/plugins/bootstrap/js/bootstrap.bundle.min
//= require admin-lte/dist/js/adminlte

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