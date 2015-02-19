var backend_url = "http://emergingfrontiers.platform.crowdvalley.com";
var homepage = {
	init: function(){
		this.submitRevoEvent();
		this.redirectLinks($(".feature-invesment-section"));
	},
	submitRevoEvent: function() {
		// $("#join-evo-submit-btn").click(function(){
		// 	var newwin = window.open("http://dev.spaceotechnologies.com/emf/landing/","_blank");
		// 	window.focus();
		// });	
	},
	redirectLinks: function(wrapper) {
		// wrapper.find("a").click(function(){
		// 	window.location.assign(backend_url);
		// 	return false;
		// });
	}
}

var landing_modal = {
	init:function() {
		var self = this;
		if ($("#landing-popup").length > 0) {
			// setTimeout(function(){
			// 	self.show();
			// },5000);

			// $(".subcribe-btn").click(function(){
			// 	self.hide();
			// });
		}
	},
	show: function(){
		$(".landing-popup").modal("show");
	},
	hide: function(){
		$(".landing-popup").modal("hide");
	}
}

$(document).ready(function(){
	landing_modal.init();
});