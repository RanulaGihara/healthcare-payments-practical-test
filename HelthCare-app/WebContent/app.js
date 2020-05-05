$(document).ready(function() {

	$("#alertSuccess").hide();
	$("#alertError").hide();
	$('#Datable').DataTable();
});
// adding a Datatable
$('#payments-table').DataTable({
	language : {
		paginate : {
			next : '<i class="ni ni-bold-right"></i>',
			previous : '<i class="ni ni-bold-left"></i>'
		}
	},
});

// SAVE ============================================
$(document).on("click", "#modelBtn", function(event) {
	// Clear status msges-------------
	$("#alertSuccess").text("");
	$("#alertSuccess").hide();
	$("#alertError").text("");
	$("#alertError").hide();

	// Form validation----------------
	var status = validateItemForm();
	// If not valid-------------------
	if (status != true) {
		$("#alertError").text(status);
		$("#alertError").show();
		return;
	}

	// If valid-----------------------
	var type = ($("#hidItemIDSave").val() == "") ? "POST" : "PUT";

	$.ajax({
		url : "paymentsAPI",
		type : type,
		data : $("#formItem").serialize(),
		dataType : "text",
		complete : function(response, status) {
			onItemSaveComplete(response.responseText, status);

		}
	});

});

$(document).on(
		"click",
		".btnUpdate",
		function(event) {
			$("#hidItemIDSave").val(
					$(this).closest("tr").find('#hidItemIDUpdate').val());
			$("#payment_method").val(
					$(this).closest("tr").find('td:eq(0)').text());
			$("#amount").val($(this).closest("tr").find('td:eq(1)').text());
			$("#date").val($(this).closest("tr").find('td:eq(2)').text());
			$("#bank_name").val($(this).closest("tr").find('td:eq(3)').text());
			$("#account_num")
					.val($(this).closest("tr").find('td:eq(4)').text());
		});


//remove data
$(document).on("click", ".btnRemove", function(event) {
	$.ajax({
		url : "paymentsAPI",
		type : "DELETE",
		data : "id=" + $(this).data("id"),
		dataType : "text",
		complete : function(response, status) {
			onItemDeleteComplete(response.responseText, status);
		}
	});
});
function onItemDeleteComplete(response, status) {
	if (status == "success") {
		var resultSet = JSON.parse(response);
		if (resultSet.status.trim() == "success") {
			$("#alertSuccess").text("Successfully deleted.");
			$("#alertSuccess").show();
			$("#divItemsGrid").html(resultSet.data);
		} else if (resultSet.status.trim() == "error") {
			$("#alertError").text(resultSet.data);
			$("#alertError").show();
		}
	} else if (status == "error") {
		$("#alertError").text("Error while deleting.");
		$("#alertError").show();
	} else {
		$("#alertError").text("Unknown error while deleting..");
		$("#alertError").show();
	}
}


function onItemSaveComplete(response, status) {
	if (status == "success") {
		var resultSet = JSON.parse(response);
		if (resultSet.status.trim() == "success") {
			$("#alertSuccess").text("Successfully saved.");
			$("#alertSuccess").show();
			$("#divItemsGrid").html(resultSet.data);
		} else if (resultSet.status.trim() == "error") {
			$("#alertError").text(resultSet.data);
			$("#alertError").show();
		}
	} else if (status == "error") {
		$("#alertError").text("Error while saving.");
		$("#alertError").show();
	} else {
		$("#alertError").text("Unknown error while saving..");
		$("#alertError").show();
	}
	$("#hidItemIDSave").val("");
	$("#formItem")[0].reset();
}

function validateItemForm() {

	if ($("#payment_method").val() == "0") {
		return "Please Select Payment Method.";
	}

	if ($("#amount").val().trim() == "") {
		return "Please Insert Amount.";
	}

	if ($("#date").val().trim() == "") {
		return "Please Insert Payment Date.";
	}

	if ($("#bank_name").val().trim() == "") {
		return "Please Insert Bank Name.";
	}

	if ($("#account_num").val().trim() == "") {
		return "Please Insert Account Number.";
	}

	return true;
}