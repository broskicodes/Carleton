const mongoose = require("mongoose");
const Schema = mongoose.Schema;

let userSchema = Schema({
	username: {
		type: String,
		required: true,
		minlength: 1,
		maxlength: 30,
		trim: true
	},
	password: {
		type: String,
		required: true,
		minlength: 1,
		maxlength: 30,
	},
	privacy: {
		type: Boolean,
		required: true
	},
});

module.exports = mongoose.model("User", userSchema);