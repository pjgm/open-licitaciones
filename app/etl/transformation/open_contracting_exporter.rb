# frozen_string_literal: true

require_relative "../../../config/application"

module OpenLicitaciones
  module ETL
    class OpenContractingExporter
      def initialize(contract)
        @contract = contract
      end

      def export
        {
          extensions: [],
          publishedDate: @contract.published_at.to_time.utc.iso8601,
          publisher: publisher_block,
          records: [
            {
              compiledRelease: {
                awards: awards_block,
                buyer: buyer_block,
                contracts: [],
                date: @contract.published_at.to_time.utc.iso8601,
                id: @contract.internal_id,
                initiationType: "tender",
                language: "es",
                ocid: "ocds-a1234567-#{@contract.internal_id}",
                parties: parties_block,
                tag: ["compiled"],
                tender: tender_block,
              },
              ocid: "ocds-a1234567-#{@contract.internal_id}",
              releases: [{
                "date": "2009-03-15T14:45:00Z",
                "tag": [
                  "planning"
                ],
                url: "http://populate.tools/open-contracting/test-release.json",
              }]
            }
          ],
          uri: "http://populate.tools/open-contracting/test.json",
          version: "1.1",
        }.to_json
      end

      private

      def parties_block
        [
          {
            id: "B123456",
            identifier: { id: @contract.contractor_name.parameterize },
            name: @contract.contractor_name,
            roles: ["buyer"],
            address: {}
          },
          {
            id: "B78890",
            identifier: { id: @contract.assignee.parameterize },
            name: @contract.assignee,
            roles: ["supplier"],
            address: {}
          }
        ]
      end

      def awards_block
        [
          {
            items: [
              {
                description: @contract.title,
                id: @contract.internal_id + "/contract",
                quantity: 1
              }
            ],
            suppliers: [
              {
                id: "B78890",
                name: @contract.assignee
              }
            ],
            value: {
              currency: "EUR",
              amount: @contract.final_amount
            },
            date: @contract.published_at.to_time.utc.iso8601,
            id: @contract.internal_id + "/award"
          }
        ]
      end

      def buyer_block
        {
          id: "B123456",
          name: @contractor_name
        }
      end

      def tender_block
        {
          awardCriteria: "bestProposal",
          awardCriteriaDetails: "The best proposal, subject to value for money requirements, will be accepted.",
          awardPeriod: {
            endDate: "2011-08-01T23:59:59Z",
            startDate: "2010-06-01T00:00:00Z"
          },
          documents: [],
          id: @contract.internal_id + "/tender",
          mainProcurementCategory: "works", #TODO
          procurementMethod: "open",
          procurementMethodDetails: "In open procedures, any interested economic operator may submit a tender in response to a contract notice. ",
          procurementMethodRationale: "An open competitive tender is required by EU Rules",
          status: "complete",
          submissionMethod: [ "electronicSubmission" ],
          title: @contract.title,
          value: {
            amount: @contract.base_budget,
            currency: "EUR"
          }
        }
      end

      def publisher_block
        {
          name: "Ville de Montr\u00e9al",
          scheme: "GB-COH",
          uid: "1234",
          "uri": "http://data.companieshouse.gov.uk/doc/company/09506232"
        }
      end
    end
  end
end
