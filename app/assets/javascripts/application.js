// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require_tree .



//////////// 単語表示のアコーディオン ///////////
$(function() {
  //最初は全てのパネルを非表示に
  $('#panel > dd').hide();
  $('#panel > dt')
    .click(function(e){
 //選択したパネルを開く
      $('+dd', this).slideToggle(100);
    })
});







///////////// フォルダにコピーボタン /////////////
$(function(){
  $("#menu").on("click", function(){
    $(this).next().not(":animated").slideToggle();
  });
});





///////////// 無限スクロール /////////////////








///////////// 単語抜き出しボタン ////////////////
$(document).ready(function() {

	$('#auto-words').on('click', function() {


		var chsentence = $('#chsentence').val();
		console.log(chsentence);
		var words = chsentence.split("");

		var array = $.grep(words, function(e){return e !== "."
				&& e !== "-"
				&& e !== ","
				&& e !== "1"
				&& e !== "2"
				&& e !== "3"
				&& e !== "4"
				&& e !== "5"
				&& e !== "6"
				&& e !== "7"
				&& e !== "8"
				&& e !== "9"
				&& e !== "0"
				&& e !== "/"
				&& e !== "|"
				&& e !== "&"
				&& e !== "%"
				&& e !== "$"
				&& e !== "。"
				&& e !== "，"
				&& e !== "！"
				&& e !== "１"
				&& e !== "２"
				&& e !== "３"
				&& e !== "４"
				&& e !== "５"
				&& e !== "６"
				&& e !== "７"
				&& e !== "８"
				&& e !== "９"
				&& e !== "０"
				&& e !== "？"
				&& e !== " "
				&& e !== "　"
		;});

		$.each(array,function(i,word){
			var target = '#sentence_words_attributes_' +i+ '_ch';
			$(target).val(word);
		});


	});


});