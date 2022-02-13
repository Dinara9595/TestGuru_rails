class Admin::BadgeRulesController < Admin::BaseController

  before_action :find_badge_rule, only: %i[show edit update destroy]

  def index
    @badge_rules = BadgeRule.all
  end

  def show; end

  def new
    @badge_rule = BadgeRule.new
  end

  def create
    @badge_rule = current_user.created_rules.build(rule_params)
    if @badge_rule.save
      redirect_to admin_badge_rule_path(@badge_rule)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @badge_rule.update(rule_params)
      redirect_to admin_badge_rule_path(@badge_rule)
    else
      render :edit
    end
  end

  def destroy
    @badge_rule.destroy
    redirect_to admin_badge_rules_path
  end

  private

  def find_badge_rule
    @badge_rule = BadgeRule.find(params[:id])
  end

  def rule_params
    params.require(:badge_rule).permit(:name)
  end
end
