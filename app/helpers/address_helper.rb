module AddressHelper
  def current_address
    @address ||= Address.first
  end
end
