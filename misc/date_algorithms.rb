require 'date'

start_date = Time.local(1954, 12, 15)
end_date = Time.now
sunday_counter = 0
while end_date >= start_date
  if end_date.strftime('%A') == 'Sunday' && end_date.strftime('%d') == '01'
    sunday_counter += 1
  end
  end_date -= 86_400
end
p sunday_counter
