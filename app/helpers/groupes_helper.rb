module GroupesHelper

	def build_groupe(groupe)
		groupe.membres.build if groupe.membres.empty?
		groupe
	end
end
