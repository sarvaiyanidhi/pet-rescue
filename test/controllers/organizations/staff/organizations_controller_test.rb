require "test_helper"
require "action_policy/test_helper"

class Organizations::Staff::OrganizationsControllerTest < ActionDispatch::IntegrationTest
  context "authorization" do
    include ActionPolicy::TestHelper

    setup do
      @organization = ActsAsTenant.current_tenant

      user = create(:staff)
      sign_in user
    end

    context "#edit" do
      should "be authorized" do
        assert_authorized_to(
          :manage?, @organization, with: Organizations::OrganizationPolicy
        ) do
          get edit_staff_organization_url(@organization)
        end
      end
    end

    context "#update" do
      setup do
        @params = {facebook_url: "https://facebook.com"}
      end

      should "be authorized" do
        assert_authorized_to(
          :manage?, @organization, with: Organizations::OrganizationPolicy
        ) do
          patch staff_organization_url(@organization), params: @params
        end
      end
    end
  end
end