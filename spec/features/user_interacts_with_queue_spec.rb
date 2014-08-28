require 'spec_helper'

feature "User interacts with the queue" do
  scenario "user adds and reorders videos in the queue" do
    category = Fabricate(:category)
    monk = Fabricate(:video, title: "Monk", category: category)
    futurama = Fabricate(:video, title: "Futurama", category: category)
    south_park = Fabricate(:video, title: "South Park", category: category)

    sign_in
    
    add_video_to_queue(monk)
    expect_video_to_be_in_queue(monk)

    visit video_path(monk)
    expect_link_not_to_be_seen("Queue It Up")

    add_video_to_queue(futurama)
    add_video_to_queue(south_park)
    
    set_video_position(monk, 3)
    set_video_position(south_park, 2)
    set_video_position(futurama, 1)

    update_queue

    expect_video_position(futurama, 1)
    expect_video_position(south_park, 2)
    expect_video_position(monk, 3)
  end

  def add_video_to_queue(video)
    visit home_path
    find("a[href='/videos/#{video.id}']").click
    click_link "Queue It Up"
  end

  def expect_video_to_be_in_queue(video)
    expect(page).to have_content(video.title)
  end

  def expect_link_not_to_be_seen(link_text)
    expect(page).to_not have_content(link_text)
  end

  def update_queue
    click_button "Update Instant Queue"ß
  end

  def set_video_position(video, position)
    within(:xpath, "//tr[contains(.,'#{video.title}')]") do
      fill_in "queue_items[][position]", with: position
    end
  end

  def expect_video_position(video, position)
    expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq(position.to_s)
  end
end