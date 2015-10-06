# encoding: utf-8

#  Copyright (c) 2012-2014, Pfadibewegung Schweiz. This file is part of
#  hitobito_pbs and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_pbs.

module Pbs::EventAbility
  extend ActiveSupport::Concern

  included do
    on(Event) do
      permission(:any).may(:modify_superior).if_education_responsible
      permission(:layer_and_below_full).
        may(:create, :destroy, :application_market, :qualify).
        in_same_layer_or_course_in_below_abteilung
    end

    on(Event::Camp) do
      permission(:any).may(:index_revoked_participations).for_participations_full_events
      permission(:group_full).may(:index_revoked_participations).in_same_group
      permission(:group_and_below_full).may(:index_revoked_participations).in_same_group_or_below
      permission(:layer_full).may(:index_revoked_participations).in_same_layer
      permission(:layer_and_below_full).may(:index_revoked_participations).in_same_layer_or_below
    end
  end

  def if_education_responsible
    user.roles.any? { |role| education_responsible_roles.include?(role.class) }
  end

  def education_responsible_roles
    [Group::Bund::AssistenzAusbildung,
     Group::Bund::MitarbeiterGs]
  end

end
