### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ 7bf051ea-f3c7-11ea-2ba6-9b439a5f6d39
using DustExtinction, Plots, LaTeXStrings

# ╔═╡ 142ffdc4-f3ce-11ea-3332-c59b5595e55c
md"""
### Recipe
"""

# ╔═╡ a10e34aa-f3c8-11ea-2bd3-7fa3ee6fcdfd
@recipe function f(model::T) where T <: DustExtinction.ExtinctionLaw
	title  --> typeof(model)
	label  --> "Rv = $(model.Rv)"
	xguide --> L"x\ \left[\mu m ^{-1}\right]"
	yguide --> L"A(x)/A(V)"
	λₗ, λᵤ = DustExtinction.bounds(model)
	λ = range(λₗ, λᵤ, length=1000)
	x = DustExtinction.aa_to_invum.(λ)
	x, model.(λ)
end

# ╔═╡ fe0881c4-f3cd-11ea-153f-b96cacc84dde
md"""
### Default plot
"""

# ╔═╡ 0a34f7da-f3cd-11ea-01c3-5f4632c4c790
begin
	law = F04()
	plot(law)
end

# ╔═╡ 13761eae-f3ce-11ea-22a1-9946c45ef8c9
md"""
### Documentation Plot
"""

# ╔═╡ 33757394-f3ce-11ea-0835-bdfed4817ab0
begin
	fig = plot()
	Rvs = [2.0, 3.1, 4.0, 5.0, 6.0]
	for Rv in Rvs
		law = F04(Rv)
		plot!(law)
	end
	fig
end

# ╔═╡ 1c459a8c-f3ce-11ea-2a1e-dd352040a3f2
md"""
### Setup
"""

# ╔═╡ 2c4d663a-f3c9-11ea-07f0-6f15eee491a0
theme(:dark)

# ╔═╡ de25c896-f3c6-11ea-3cd5-f5ad030e1601
begin
	import Pkg
	Pkg.activate(".")
end

# ╔═╡ Cell order:
# ╟─142ffdc4-f3ce-11ea-3332-c59b5595e55c
# ╠═a10e34aa-f3c8-11ea-2bd3-7fa3ee6fcdfd
# ╟─fe0881c4-f3cd-11ea-153f-b96cacc84dde
# ╠═0a34f7da-f3cd-11ea-01c3-5f4632c4c790
# ╟─13761eae-f3ce-11ea-22a1-9946c45ef8c9
# ╠═33757394-f3ce-11ea-0835-bdfed4817ab0
# ╟─1c459a8c-f3ce-11ea-2a1e-dd352040a3f2
# ╠═2c4d663a-f3c9-11ea-07f0-6f15eee491a0
# ╠═7bf051ea-f3c7-11ea-2ba6-9b439a5f6d39
# ╠═de25c896-f3c6-11ea-3cd5-f5ad030e1601
