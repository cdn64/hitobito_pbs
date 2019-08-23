#  Copyright (c) 2012-2015, Pfadibewegung Schweiz. This file is part of
#  hitobito_pbs and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_pbs.
#
#= require 'shepherd.min'

updateLocalScoutContactFieldsVisibility = ->
  canton_field = $('select#event_canton')
  if canton_field.length
    local_scout_fields = $('#event_local_scout_contact_present, #event_local_scout_contact')
    if local_scout_fields.length
      if canton_field.val() == 'zz'
        local_scout_fields.closest('.control-group').show()
      else
        local_scout_fields.closest('.control-group').hide()

$(document).on('change', 'select#event_canton', updateLocalScoutContactFieldsVisibility)

initializeDemoTour = () ->
  tour = new Shepherd.Tour({
    defaultStepOptions: {
      cancelIcon: {
        enabled: true
      },
      useModalOverlay: true,
      buttons: [
        {
          action: -> this.back(),
          classes: 'shepherd-button-secondary',
          text: 'Back'
        },
        {
          action: -> this.next(),
          text: 'Next'
        }
      ],
      modalOverlayOpeningPadding: 8,
      # classes: 'class-1 class-2',
      # scrollTo: { behavior: 'smooth', block: 'center' }
    },
    steps: [
      {
        title: 'Lager erstellen',
        text: " Achtung: Lager können auf verschiedenen Ebenen erstellt werden. Ein Lager kann sowohl auf Ebene Abteilung, wie auch in einer einzelnen Gruppe (z.B: Pfadi, Rover usw.) eröffnet werden. Eine Anmeldung zum Lager ist nur für die Mitglieder der jeweiligen Gruppe möglich.",
        attachTo: {
          element: '#content h1',
          on: 'bottom'
        }
      },
      {
        title: 'Lagername',
        text: "So erscheint das Lager in der Lagerübersicht. Der Name kann frei bestimmt werden. Z. B. „Sommerlager Pfadistufe“ usw.",
        attachTo: {
          element: '#event_name',
          on: 'bottom'
        }
      }
    ],
    useModalOverlay: true,
    id: 'creating'
  })

  tour.start()

$ ->
  updateLocalScoutContactFieldsVisibility()
  initializeDemoTour()
