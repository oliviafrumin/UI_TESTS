module RewardsPage
  include Capybara::DSL

  def add_reward(name)
    click_link 'Add new reward'
    fill_in 'reward_name', with: name # + '_Name'
    fill_in 'reward_display_name', with: name + '_Display_Name'
    fill_in 'reward_description', with: name + '_Description'
    # upload an image here
    find(:xpath, "//div[@id='reward_image_url']//input[@name='file']", wait: 2).set(File.absolute_path('./lib/data/reward.png'))
    sleep 3
    # change img
    expect(find(:xpath, "//a[contains(text(),'Change this picture')]", wait: 5).visible?).to be true
    find(:xpath, "//div[@id='reward_image_url']//input[@name='file']", wait: 2).set(File.absolute_path('./lib/data/deal.png'))
    sleep 5
    # delete img
    find(:xpath, "//div[@id='reward_image_url']//a[@class='delete_upload_image'][contains(text(),'Delete this picture')]", wait: 5).click
    # add img again
    find(:xpath, "//div[@id='reward_image_url']//input[@name='file']", wait: 2).set(File.absolute_path('./lib/data/reward.png'))
    fill_in 'reward_points', with: '30'
    fill_in 'reward_instructions', with: name + '_Redemption_Instructions'
    status = find(:id, 'reward_status', wait: 2)
    status.click unless status.checked?
    click_link_or_button 'Save'
  end

  def modify_reward(name)
    find(:xpath, "//a/dt[contains(text(), '" + name + "')]", wait: 2).click
    fill_in 'reward_points', with: '-35', wait: 1
    find(:xpath, "//textarea[@id='reward_description']").click
    find(:xpath, "//div[@class='flash_error']/span[contains(text(),'Please enter non-negative number.')]", wait: 1)
    fill_in 'reward_points', with: '35', wait: 2
    find(:xpath, "//textarea[@id='reward_description']").click
    find(:xpath, "//select[@id='reward_tiers_required']/option[@value='true']", wait: 2).click
    find(:css, "#reward_tier_ids_3923", wait: 2).click
    find(:xpath, "//select[@id='reward_badge_id']/option[@value='38744']", wait: 2).click
    find(:xpath, "//select[@id='reward_event_type']/option[@value='answer']", wait: 2).click
    find(:xpath, "//input[@id='reward_auto_redeem']", wait: 2).click
    find(:xpath, "//input[@id='reward_view_options_iframe_hidden']", wait: 2).click
    click_link_or_button 'Save'
  end

  def modify_reward_limit(name)
    find(:xpath, "//a/dt[contains(text(), '" + name + "')]", wait: 2).click
    find(:xpath, "//select[@id='reward_limit_enabled']/option[@value='true']").click
    fill_in 'limited_redemption_lifetime_value', with: '-1'
    find(:xpath, "//select[@id='reward_limit_enabled']/option[@value='true']", wait: 3).click
    find(:xpath, "//*[contains(text(),'Please enter non-negative number.')]")
    fill_in 'limited_redemption_lifetime_value', with: '1'
    find(:xpath, "//select[@id='reward_cap_attributes_timeframe_select']/option[@value='lifetime']", wait: 2).click
    assert_text('member lifetime')
    find(:xpath, "//input[@id='limited_redemption_days_value']", wait: 5).click
    fill_in 'limited_redemption_days_value', with: '-2'
    find(:xpath, "//input[@id='limited_redemption_days_value']", wait: 1).click
    find(:xpath, "//*[contains(text(),'Please enter non-negative number.')]")
    fill_in 'limited_redemption_days_value', with: '2'
    fill_in 'reward_cap_attributes_timeframe_days', with: '-1'
    find(:xpath, "//input[@id='limited_redemption_days_value']").click
    find(:xpath, "//*[contains(text(),'Please enter non-negative number.')]")
    fill_in 'reward_cap_attributes_timeframe_days', with: '1'
    find(:xpath, "//input[@id='limited_redemption_days_value']", wait: 2).click
    have_none_of_selectors(:xpath, "//div[@class='flash_error']/span[contains(text(),'Please enter non-negative number.')]")
    assert_text('times in')
    assert_text('days')
    find(:xpath, "//input[@id='reward_cap_attributes_timeframe_between']", wait: 2).click
    fill_in 'limited_redemption_between_value', with: '-2'
    find(:xpath, "//input[@id='reward_cap_attributes_timeframe_between']", wait: 2).click
    find(:xpath, "//*[contains(text(),'Please enter non-negative number.')]")
    fill_in 'limited_redemption_between_value', with: '2'
    find(:xpath, "//input[@id='reward_cap_attributes_timeframe_between']", wait: 2).click
    have_none_of_selectors(:xpath, "//div[@class='flash_error']/span[contains(text(),'Please enter non-negative number.')]")
    find(:xpath, "//input[@id='cap_start_at_readonly']", wait: 2).click
    find(:xpath, "//div[@id='ui-datepicker-div']")
    find(:xpath, "//div[@id='ui-datepicker-div']/table/tbody/tr/td/a[.//text()='" + Date.today.day.to_s + "']", wait: 2).click
    find(:xpath, "//input[@id='cap_end_at_readonly']", wait: 2).click
    find(:xpath, "//div[@id='ui-datepicker-div']/table/tbody/tr/td/a[.//text()='" + Date.today.day.to_s + "']", wait: 2).click
    find(:xpath, "//select[@id='reward_limit_enabled']/option[@value='false']", wait: 5).click
    click_link_or_button 'Save'
  end

  def modify_reward_history(name)
    find(:xpath, "//a/dt[contains(text(), '" + name + "')]", wait: 2).click
    page.execute_script "window.scrollTo(0,700)"
    click_link_or_button 'Add rule'
    sleep 3
    find(:css, "#queryBuilder_0_rule_0", wait: 2).click
    find(:css, "#queryBuilder_0_rule_0 > div.rule-filter-container > select > option:nth-child(2)", wait: 2).click
    # binding.pry
    find(:css, "#queryBuilder_0_rule_0 > div.rule-operator-container > select > option:nth-child(2)", wait: 2).click
    find(:css, "#queryBuilder_0_rule_0 > div.rule-value-container > select > option:nth-child(4)", wait: 2).click
    find(:css, "#timeframe_0_always", wait: 2).click
    find(:xpath, "//input[@id='timeframe_0_year_to_date']", wait: 2).click
    find(:xpath, "//input[@id='timeframe_0_previous_calendar_year']", wait: 2).click
    find(:xpath, "//input[@id='timeframe_0_within_member_year']", wait: 2).click
    find(:xpath, "//input[@id='timeframe_0_previous_member_year']", wait: 2).click
    find(:xpath, "//input[@id='timeframe_0_days_ago']").click
    find(:xpath, "//select[@id='timeframe_0_days_ago_operator']/option[@value='>=']").click
    page.execute_script "window.scrollTo(0,700)"
    find(:xpath, "//input[@id='timeframe_0_days']").set(10)
    sleep 5
    find(:xpath, "//a[@class='add_condition secondary_button']").click
    find(:xpath, "//input[@id='timeframe_1_custom_dates']").click
    find(:xpath, "//input[@id='timeframe_1_start_date_localized']").click
    find(:xpath, "//a[@class='ui-datepicker-prev ui-corner-all']").click
    find(:xpath, "//a[@class='ui-datepicker-next ui-corner-all']").click
    sleep 2
    find(:xpath, "//table[@class='ui-datepicker-calendar']//*[contains(text(),'18')]").click
    find(:xpath, "//div[@id='timeframe-panel-1']//div[@class='end_date']/input[1]").click
    find(:xpath, "//table[@class='ui-datepicker-calendar']//*[contains(text(),'20')]").click
    find(:xpath, "//a[@class='delete_condition_link small_button']").click
    expect(find(:xpath, "//a[contains(text(),'Create Reward Redemption Email')]", wait: 5).visible?).to be true
    click_link_or_button 'Save'
  end

  def delete_reward(name)
    find(:xpath, "//a/dt[contains(text(), '" + name + "')]", wait: 2).click
    click_link_or_button 'Delete Reward'
    find(:xpath, "//div[@class='delete_overlay']//a[@class='primary_button del_button' and contains(text(), 'Delete')]", wait: 2).click
  end

end
