When /^I want to calculate:$/ do |table|
  table.rows_hash.each do |key, value|
    case key
    when 'From', 'To'
      select value, from: "#{key.downcase}_currency"
    else
      fill_in key.downcase, with: value
    end
  end
  click_button 'Calculate'
end

Then /^I should see the result "(.*?)"$/ do |res|
  expect(page).to have_content(res)
end

Then /^I should not see a result$/ do
  expect(page).to have_content('There is no data for the date you have selected. Please try again')
end

Then /^I should see the message "(.*?)"$/ do |message|
  expect(page).to have_content(message)
end
