<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="model.payments"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="./lib/jquery-3.5.0.min.js"></script>
<link rel="stylesheet" href="./lib/fontawesome/css/all.css" />
<link rel="stylesheet" href="./lib/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" href="./lib/bootstrap/css/bootstrap-select.css" />
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.19/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet"
	href="https://cdn.datatables.net/buttons/1.6.0/css/buttons.dataTables.min.css">
<link rel="stylesheet" href="./app.css" />
<title>Health care - Payment Service</title>
</head>

<body>
	<div class="container mt-5">
		<div class="row">
			<div class="col-12 text-right">
				<button type="button" id="btnAdd" class="btn btn-info"
					data-title="Add" data-toggle="modal" data-target="#add"
					title="Add a Payment">
					<i class="fas fa-plus-square"></i> <span> add new payments </span>
				</button>
			</div>
			<div class="col-12 text-center">
				<h1 class="text-success">
					<b> Payments List </b>
				</h1>
				</button>
			</div>


		</div>
	</div>
	<div class="container-fluid mt-5">
		<div class="row">
			<div class="col-lg-12 content-justify-center">
				<div class="card-body">
					<div class="card-shadow">
						<div class="table-responsive">
							<table id="payments-table" class="table">
								<thead>
									<th scope="col">Payment Method</th>
									<th scope="col">Amount</th>
									<th scope="col">Payment Date</th>
									<th scope="col">Bank Name</th>
									<th scope="col">Account Number</th>
									<th scope="col">Update</th>
									<th scope="col">Delete</th>
								</thead>
								<tbody id="divItemsGrid">
									<%
										payments payObj = new payments();
										out.print(payObj.readItems());
									%>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>


			<div class="modal fade" style="opacity: 0.9;" id="add" tabindex="-1"
				role="dialog" aria-labelledby="edit" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title" id="Add-heading"></h4>
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">
								<i class="fas fa-window-close"></i>
							</button>
						</div>
						<div class="modal-body">
							<form id="formItem" name="formItem">
								<div class="form-group">
									<input type="hidden" id="hidItemIDSave" name="hidItemIDSave"
										value="">
								</div>
								<div class="form-group">
									<label for="payment_method"><b>Payment Method</b></label>
									<div class="form-group">
										<select class="form-control" id="payment_method" name="payment_method"> 
											<option value="0"></option>
											<option>Master-Cards</option>
											<option>Visa-Cards</option>
											<option>Paypal</option>
										</select>
									</div>
								</div>

								<div class="form-group">
									<label for="amount"><b>Amount</b></label> <input type="number"
										class="form-control" id="amount" name="amount" placeholder="Your Amount">
								</div>

								<div class="form-group">
									<label for="date"><b>Payment Date</b></label> <input
										type="date" name="date" class="form-control" id="date"
										placeholder="Payment Date">
								</div>


								<div class="form-group">
									<label for="bank_name"><b>Bank Name </b></label> <input
										type="text" class="form-control" id="bank_name" name="bank_name"
										placeholder="Your Payment Bank">
								</div>

								<div class="form-group">
									<label for="account_num"><b>Account Number</b></label> <input
										type="number" class="form-control" id="account_num" name="account_num"
										placeholder=" Enter Your Account Number">
								</div>
								<div id="alertSuccess" class="text-success"></div>
								<div id="alertError" class="text-danger"></div>
							</form>

						</div>
						<div class="modal-footer ">
							<button type="button" class="btn btn-success btn-lg"
								id="modelBtn" style="width: 100%;">Save</button>
						</div>
					</div>
					<!-- /.modal-content -->
				</div>
				<!-- /.modal-dialog -->
			</div>



			<div class="modal fade" id="delete" tabindex="-1" role="dialog"
				aria-labelledby="edit" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">
								<i class="fas fa-window-close"></i>
							</button>
							<h4 class="modal-title custom_align" id="Heading">Delete
								this entry</h4>
						</div>
						<div class="modal-body">

							<div class="alert alert-danger">
								<span class="glyphicon glyphicon-warning-sign"></span> Are you
								sure you want to delete this Record?
							</div>

						</div>
						<div class="modal-footer ">
							<button type="button" class="btn btn-success">
								<span class="glyphicon glyphicon-ok-sign"></span>Â Yes
							</button>
							<button type="button" class="btn btn-default"
								data-dismiss="modal">
								<span class="glyphicon glyphicon-remove"></span>Â No
							</button>
						</div>
					</div>

				</div>

			</div>






			<script
				src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
			<script
				src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap4.min.js"></script>
			<script src="./lib/bootstrap/js/bootstrap.bundle.min.js"></script>
			<script src="./lib/bootstrap/js/bootstrap-select.min.js"></script>
			<script src="./app.js"></script>
</body>

</html>