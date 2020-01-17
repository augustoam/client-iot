$(document).on('turbolinks:load', function() {
  // barra de progresso
  Turbolinks.BrowserAdapter.prototype.showProgressBarAfterDelay = function() {
    this.progressBarTimeout = setTimeout(this.showProgressBar, 100);
  };
  $(document).ready(function() {

    $('.card-color').click(function() {
      comandoInfraVermelho($(this));
    });

    $('.repeat-select').each(function() {
      updateValueRepeat($(this));
    })

    $('.repeat-select').change(function() {
      // defaultValueRepeat($(this));
    })

    $('select#group_automation_condition_repeat li').click(function(element, v) {
      // console.log(element);
        // defaultValueRepeat($(this));
    });

  });

}).on("click", "tr[data-href] td", function(e) {
    var $td = $(this);
    if($td.find("a.btn").length === 0) // Apenas se a célula não possuir um botão
      Turbolinks.visit($td.parents("tr:first").data("href"));
})

function updateValueRepeat(element) {
  if ($('.repeat-data-content')[0].innerText.length > 0) {
    json = JSON.parse($('.repeat-data-content')[0].innerText)
    json.forEach(function(data) {
      for (var i = 0; i < $('#group_automation_condition_repeat')[0].options.length; i++) {
        if (data === $('#group_automation_condition_repeat')[0].options[i].value) {
          $('#group_automation_condition_repeat')[0].options[i].selected = true;
        }
      }
    })
  }
}

defaultValueRepeat = (element) => {
  // debugger
  if (element[0].value == 'once') {
    $("select#group_automation_condition_repeat option").map(function() {
      if ($(this).index() != 0)
        $(this)[0].selected = false;
    });
  }


  if (element[0].value == 'every_day') {
    $("select#group_automation_condition_repeat option").map(function() {
      if ($(this).index() != 1)
        $(this)[0].selected = false;
    });
  }

  $('#group_automation_condition_repeat').formSelect();

    // json = JSON.parse($('.repeat-data-content')[0].innerText)
    // json.forEach(function(data) {
    //   for (var i = 0; i < $('#group_automation_condition_repeat')[0].options.length; i++) {
    //     if (data === $('#group_automation_condition_repeat')[0].options[i].value) {
    //       $('#group_automation_condition_repeat')[0].options[i].selected = true;
    //     }
    //   }
    // })

}
