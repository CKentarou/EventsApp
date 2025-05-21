class User < ApplicationRecord
  before_destroy :check_all_events_finished

  has_many :created_events, class_name: 'Event', foreign_key: 'owner_id', dependent: :nullify
  has_many :tickets, dependent: :nullify
  has_many :participating_events, through: :tickets, source: :event

  def self.find_or_create_from_auth_hash!(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    nickname = auth_hash[:info][:nickname]
    image_url = auth_hash[:info][:image]

    User.find_or_create_by!(provider: provider, uid: uid) do |user|
      user.name = nickname
      user.image_url = image_url
    end
  end

  private

  def check_all_events_finished
    Rails.logger.debug "Running check_all_events_finished callback"
  
    now = Time.zone.now
    if created_events.where("end_at > ?", now).exists?
      errors.add(:base, "あなたが作成した未終了のイベントがあります")
    end
  
    if participating_events.where("end_at > ?", now).exists?
      errors.add(:base, "あなたが参加する未終了のイベントがあります")
    end
  
    if errors.empty?
      Rails.logger.debug "エラーがないため削除を続行します"
    else
      Rails.logger.debug "エラーがあるため削除を中断します: #{errors.full_messages}"
      throw(:abort)
    end
  end
end
