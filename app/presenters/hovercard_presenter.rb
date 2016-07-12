class HovercardPresenter

  attr_accessor :person

  # initialize the presenter with the given Person object
  def initialize(person)
    raise ArgumentError, "the given object is not a Person" unless person.class == Person

    self.person = person
  end

  # returns the json representation of the Person object for use with the
  # hovercard UI
  def to_json(options={})
    {  :id => person.id,
       :avatar => avatar('medium'),
       :url => profile_url,
       :name => person.name,
       :handle => person.diaspora_handle
       # :mention =>
       # :message =>
    }.to_json(options)
  end

  # get the image url of the profile avatar for the given size
  # possible sizes: 'small', 'medium', 'large'
  def avatar(size="medium")
    if !["small", "medium", "large"].include?(size)
      raise ArgumentError, "the given parameter is not a valid size"
    end

    person.image_url("thumb_#{size}".to_sym)
  end

  def mention
    if params[:person_id] && fetch_person(params[:person_id])
      @aspect = :profile
      @contact = current_user.contact_for(@person)
      if @contact
        @aspects_with_person = @contact.aspects.load
        @aspect_ids = @aspects_with_person.map(&:id)
        gon.aspect_ids = @aspect_ids
        render layout: nil
      else
        @aspects_with_person = []
      end
    elsif request.format == :mobile
      @aspect = :all
      @aspects = current_user.aspects.load
      @aspect_ids = @aspects.map(&:id)
      gon.aspect_ids = @aspect_ids
    else
      redirect_to stream_path
    end
  end

  def message
  end

  # return the (relative) url to the user profile page.
  # uses the 'person_path' url helper from the rails routes
  def profile_url
    Rails.application.routes.url_helpers.person_path(person)
  end
end
