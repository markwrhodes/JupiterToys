require '.\Browser'
include Browser

# A class to represent the Contact page.
class Contact

    def initialize
        @page_ids = {
            'header_error_message_div_id'       => 'header-message',
            'forename_error_span_id'            => 'forename-err',
            'email_error_span_id'               => 'email-err',
            'message_error_span_id'             => 'message-err',
            'forename_input_id'                 => 'forename',
            'surname_input_id'                  => 'surname',
            'email_input_id'                    => 'email',
            'telephone_input_id'                => 'telephone',
            'message_input_id'                  => 'message',
            'successful_submission_message_css' => 'div[class="alert alert-success"]'
        }
    end

    def goto_contact_page
        Browser.goto_page('Contact')
        Browser.wait_for_href_with_text(5, 'Submit')
    end

    def click_contact_submit_button
        Browser.click_href_with_text(5, 'Submit')
    end

    def get_header_error
        Browser.get_element_text_by_id(@page_ids['header_error_message_div_id'])
    end

    def get_forename_error
        Browser.get_element_text_by_id(@page_ids['forename_error_span_id'])
    end

    def get_email_error
        Browser.get_element_text_by_id(@page_ids['email_error_span_id'])
    end

    def get_message_error
        Browser.get_element_text_by_id(@page_ids['message_error_span_id'])
    end

    # Usage:
    #   feedback_details = {'forename' => 'Mark', 'surname' => 'Rhodes', 'email' => 'mark.rhodes@gmail.com', 'telephone' => '123456' 'message' => 'Test message'}
    #   contact.add_feedback(feedback_details)
    def add_feedback(feedback_details, click_submit = true)
        feedback_details.each do |input_type, input_value|
            case input_type
            when 'forename'
                Browser.set_element_text_by_id(@page_ids['forename_input_id'], input_value)
            when 'surname'
                Browser.set_element_text_by_id(@page_ids['surname_input_id'], input_value)
            when 'email'
                Browser.set_element_text_by_id(@page_ids['email_input_id'], input_value)
            when 'telephone'
                Browser.set_element_text_by_id(@page_ids['telephone_input_id'], input_value)
            when 'message'
                Browser.set_element_text_by_id(@page_ids['message_input_id'], input_value)
            end
        end
        if click_submit
            click_contact_submit_button
        end
        Browser.wait_for_href_with_text(20, '« Back')
    end

    # Returns true if any errors are present on the mandatory contact submission fields.
    def contact_submit_errors_present?
        errors_present = false
        if Browser.element_displayed?(@page_ids['header_error_message_div_id'])
            errors_present = true
        elsif Browser.element_displayed?(@page_ids['forename_error_span_id'])
            errors_present = true
        elsif Browser.element_displayed?(@page_ids['email_error_span_id'])
            errors_present = true
        elsif Browser.element_displayed?(@page_ids['message_error_span_id'])
            errors_present = true
        end
        return errors_present
    end

    def get_successful_submission_message
        Browser.get_element_text_by_css(@page_ids['successful_submission_message_css'])
    end

end