### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ 7bf051ea-f3c7-11ea-2ba6-9b439a5f6d39
using DustExtinction, Plots, LaTeXStrings, Unitful

# ╔═╡ de25c896-f3c6-11ea-3cd5-f5ad030e1601
begin
	using Pkg
	Pkg.activate("../")
end

# ╔═╡ 142ffdc4-f3ce-11ea-3332-c59b5595e55c
md"""
### Recipe
"""

# ╔═╡ fe0881c4-f3cd-11ea-153f-b96cacc84dde
md"""
### Default plot
"""

# ╔═╡ 422ceeae-fefe-11ea-023e-af7d84a36bbf
plot(F04(), N=800, λ_lims=(100.00, 3333.33), unit=u"nm")

# ╔═╡ 13761eae-f3ce-11ea-22a1-9946c45ef8c9
md"""
### Documentation Plot
"""

# ╔═╡ 9ef14e64-fefe-11ea-01b3-bb9dac581295
let
	Rvs = [2.0, 3.1, 4.0, 5.0, 6.0]
	plot(F04.(Rvs), N=800, λ_lims=(100.00, 3333.33), unit=u"nm")
end

# ╔═╡ 1c459a8c-f3ce-11ea-2a1e-dd352040a3f2
md"""
### Setup
"""

# ╔═╡ 18c96542-fef9-11ea-316b-c5dd6e0700bf
to_angstrom_unitless(w, unit) = uconvert.(u"Å", w*unit) .|> ustrip

# ╔═╡ 2c4d663a-f3c9-11ea-07f0-6f15eee491a0
theme(:dark)

# ╔═╡ 14f49588-fef2-11ea-05ff-e3b7c2411419
const DE = DustExtinction;

# ╔═╡ a10e34aa-f3c8-11ea-2bd3-7fa3ee6fcdfd
let
	@recipe function f(
		model::DE.ExtinctionLaw;
		N = 1_000,
		λ_lims = DE.bounds(model),
		unit = u"Å",
	)
		title  --> typeof(model)
		label  --> "Rv = $(model.Rv)"
		xguide --> L"x\ \left[\mu m ^{-1}\right]"
		yguide --> L"A(x)/A(V)"
		λ = range(λ_lims..., length=N)
		if unit != u"Å"
			λ = to_angstrom_unitless.(λ, unit)
		end
		x = DE.aa_to_invum.(λ)
		x, model.(λ)
	end
end

# ╔═╡ 91f52a10-fee9-11ea-1540-6b85b54c6dd6
let
	# This recipe assumes that all models are in the same family
	@recipe function f(
		models::T;
		N=1_000,
		λ_lims = DE.bounds(models[1]),
		unit = u"Å",
	) where T <: Vector{E} where E <: DE.ExtinctionLaw
		title  --> typeof(models[1])
		label  --> hcat([model.Rv for model in models]...)
		legendtitle --> L"R_v"
		legend --> :topleft
		xguide --> L"x\ \left[\mu m ^{-1}\right]"
		yguide --> L"A(x)/A(V)"
		λ = range(λ_lims..., length=N)
		if unit != u"Å"
			λ = to_angstrom_unitless.(λ, unit)
		end
		x = DE.aa_to_invum.(λ)
		x, hcat([model.(λ) for model in models]...)
	end
end

# ╔═╡ Cell order:
# ╟─142ffdc4-f3ce-11ea-3332-c59b5595e55c
# ╠═a10e34aa-f3c8-11ea-2bd3-7fa3ee6fcdfd
# ╟─fe0881c4-f3cd-11ea-153f-b96cacc84dde
# ╠═422ceeae-fefe-11ea-023e-af7d84a36bbf
# ╟─13761eae-f3ce-11ea-22a1-9946c45ef8c9
# ╠═91f52a10-fee9-11ea-1540-6b85b54c6dd6
# ╠═9ef14e64-fefe-11ea-01b3-bb9dac581295
# ╟─1c459a8c-f3ce-11ea-2a1e-dd352040a3f2
# ╠═18c96542-fef9-11ea-316b-c5dd6e0700bf
# ╠═2c4d663a-f3c9-11ea-07f0-6f15eee491a0
# ╠═14f49588-fef2-11ea-05ff-e3b7c2411419
# ╠═7bf051ea-f3c7-11ea-2ba6-9b439a5f6d39
# ╠═de25c896-f3c6-11ea-3cd5-f5ad030e1601
