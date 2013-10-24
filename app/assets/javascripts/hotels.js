$(function(){
  var hotels = $('.hotel-grid');
  var toggles = hotels.find('.btn-toggle');

  toggles.on('click', function(e){
    var btn = $(this);
    var hotel = btn.parent().parent().parent();

    var summary = hotel.find('.summary-info');
    var price = hotel.find('.price-info');

    var summaryBtn = hotel.find('.btn-summary');
    var priceBtn = hotel.find('.btn-price');

    e.preventDefault();

    if(btn.hasClass('btn-summary')) {
      summary.removeClass('hidden');
      summaryBtn.addClass('hidden');

      price.addClass('hidden');
      priceBtn.removeClass('hidden');
    } else {
      price.removeClass('hidden');
      priceBtn.addClass('hidden');

      summary.addClass('hidden');
      summaryBtn.removeClass('hidden');
    }
  });
});