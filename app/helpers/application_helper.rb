module ApplicationHelper
  def day_of_week
    Date::DAYNAMES[Date.today.wday]
  end

  def time_select_string
      '<option value=""></option>
      <option value="0">12:00 am</option>
      <option value="30">12:30 am</option>
      <option value="60">1:00 am</option>
      <option value="90">1:30 am</option>
      <option value="120">2:00 am</option>
      <option value="150">2:30 am</option>
      <option value="180">3:00 am</option>
      <option value="210">3:30 am</option>
      <option value="240">4:00 am</option>
      <option value="270">4:30 am</option>
      <option value="300">5:00 am</option>
      <option value="330">5:30 am</option>
      <option value="360">6:00 am</option>
      <option value="390">6:30 am</option>
      <option value="420">7:00 am</option>
      <option value="450">7:30 am</option>
      <option value="480">8:00 am</option>
      <option value="510">8:30 am</option>
      <option value="540">9:00 am</option>
      <option value="570">9:30 am</option>
      <option value="600">10:00 am</option>
      <option value="630">10:30 am</option>
      <option value="660">11:00 am</option>
      <option value="690">11:30 am</option>
      <option value="720">12:00 pm</option>
      <option value="750">12:30 pm</option>
      <option value="780">1:00 pm</option>
      <option value="810">1:30 pm</option>
      <option value="840">2:00 pm</option>
      <option value="870">2:30 pm</option>
      <option value="900">3:00 pm</option>
      <option value="930">3:30 pm</option>
      <option value="960">4:00 pm</option>
      <option value="990">4:30 pm</option>
      <option value="1020">5:00 pm</option>
      <option value="1050">5:30 pm</option>
      <option value="1080">6:00 pm</option>
      <option value="1110">6:30 pm</option>
      <option value="1140">7:00 pm</option>
      <option value="1170">7:30 pm</option>
      <option value="1200">8:00 pm</option>
      <option value="1230">8:30 pm</option>
      <option value="1260">9:00 pm</option>
      <option value="1290">9:30 pm</option>
      <option value="1320">10:00 pm</option>
      <option value="1350">10:30 pm</option>
      <option value="1380">11:00 pm</option>
      <option value="1410">11:30 pm</option>'.html_safe
  end
end
