class TestPassagesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show result update]

  def show; end

  def result
    @badges = Badge.find(params[:badges_ids]) if params[:badges_ids]
  end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      TestsMailer.completed_test(@test_passage).deliver_now
      @user_badges = BadgeAdditionService.new(@test_passage, current_user).call
      add_badges_user(@user_badges, current_user)
      redirect_to result_test_passage_path(@test_passage, badges_ids: badges_ids_user(@user_badges))
    else
      render :show
    end
  end

  def set_badge(number)
    @badge = Badge.find(number)
  end

  def add_badges_user(badges, user)
    badges.each {|badge| user.badges.push(badge)} if badges.any?
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def badges_ids_user(user_badges)
    user_badges.map {|badge| badge.id} if user_badges.any?
  end
end
