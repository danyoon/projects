function toggleHotelInfo(){
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
}

function uploadHotelPhoto(){
  var form = $('form.hotel-photo-upload-form');
  var file = form.find('input[type="file"]');
  var submit = form.find('input[type="submit"]');

  file.on('change', function(e){
    e.preventDefault();
    var form = $(this).parent();

    form.submit();
  });

  submit.on('click', function(e){
    e.preventDefault();
    var field = $(this).parent().find('input[type="file"]');

    field.click();
  });
}

$(function(){
  toggleHotelInfo();
  uploadHotelPhoto();
});