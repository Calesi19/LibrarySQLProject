"use strict";

function SetModalSpinner(modal) {
    SetModalContent(modal,
        `<div class="text-center">
            <i class="fa-solid fa-spin fa-circle-notch fa-3x text-primary"></i>
        </div>`
    );
}

function SetModalContent(modal, content) {
    modal.html(
        `<div class="modal-header">
            <button type="button" class="btn close" data-bs-dismiss="modal" aria-label="Close">
                <i class="fa-solid fa-xmark"></i>
            </button>
        </div>
        <div class="modal-body">
            ${content}
        </div>
        <div class="modal-footer"></div>`
    );
}

function AddValidation(form) {
    form.removeData('validator');
    form.removeData('unobtrusiveValidation');
    $.validator.unobtrusive.parse(form);
}

(function ($) {
    $.fn.spin = function () {
        return this.each(function () {
            $(this).attr('data-style', 'zoom-out');
            let l = Ladda.create(this);
            l.start();
        });
    }

    $.fn.stopSpin = function () {
        return this.each(function () {
            let l = Ladda.create(this);
            l.stop();
        });
    }
}(jQuery));

$(document).on('click', '.btn-delete', function () {
    let btn = $(this);
    let id = btn.data('id');
    Swal.fire({
        title: "Are you sure?",
        text: "Deleting is permanent.",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "var(--bs-danger)",
        cancelButtonColor: "var(--bs-gray)",
        confirmButtonText: "Delete"
    })
    .then(function (result) {
        if (!result.isConfirmed) {
            return;
        }
        btn.removeClass('btn-outline-danger');
        btn.addClass('btn-danger');
        btn.spin();
        $.post({
            url: btn.data('url'),
            success: function (response) {
                if (response.msg) {
                    this.error(response);
                }
                else {
                    $(`tr[data-id="${id}"]`).remove();
                }
            },
            error: function (response) {
                let msg = response.msg || "Failed to delete.";
                btn.addClass('btn-outline-danger');
                btn.removeClass('btn-danger');
                btn.stopSpin();
                Swal.fire("Error!", msg, "error");
            }
        });
    });
});

$(document).on('click', '.btn-edit', function () {
    let id = $(this).data('id');
    let modalContent = $('.modal-content');
    let editBtn = $(this);
    editBtn.spin();
    SetModalSpinner(modalContent);
    $('.modal').modal('show');
    $.get({
        url: editBtn.data('url'),
        success: function (response) {
            modalContent.html(response);
            let form = modalContent.find('form');
            AddValidation(form);
            modalContent.find('#btnSave').click(function () {
                if (!form.valid()) { return; }
                let saveBtn = $(this);
                saveBtn.spin();
                $.post({
                    url: form.attr('action'),
                    data: form.serialize(),
                    success: function (response) {
                        if (response.msg) {
                            this.error(response);
                        }
                        else {
                            $('.modal').modal('hide');
                            $(`tr[data-id="${id}"]`).remove();
                            $('tbody').append(response);
                        }
                    },
                    error: function (response) {
                        let msg = response.msg || "Failed to save.";
                        Swal.fire("Error!", msg, "error");
                    },
                    complete: function () {
                        saveBtn.stopSpin();
                    }
                })
            });
            if (window.initForm) {
                window.initForm(modalContent);
            }
        },
        error: function () {
            let msg = "Failed to load the editor.";
            $('.modal').modal('hide');
            Swal.fire("Error!", msg, "error");
        },
        complete: function () {
            editBtn.stopSpin();
        }
    });
});
