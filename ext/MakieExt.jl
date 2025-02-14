module MakieExt
    using DustExtinction
    import DustExtinction: bounds, aa_to_invum, ExtinctionLaw, dplot, dplot!
    using Makie: Makie, convert_arguments, PointBased, heatmap, Colorbar

    function Makie.convert_arguments(P::PointBased, law::ExtinctionLaw)
        aa = range(bounds(law)...; length=1_000)
        m = map(law, aa)
        invum = map(aa_to_invum, aa)
        return convert_arguments(P, invum, m) # (Plot type, x, y)
    end

    Makie.plottype(::ExtinctionLaw) = Lines

    function dplot(dustmap=SFD98Map(); lrange=(-3, 3), brange=(-1, 1))
        l = range(lrange..., length=400)
        b = range(brange..., length=300)
        m = [dustmap(li, bj) for li in l, bj in b]

        fig, ax, p = heatmap(l, b, m; colorrange=(0, 3), colormap=:cividis)
        ax.xlabel = "l (°)"
        ax.ylabel = "b (°)"
        Colorbar(fig[1, 2], p; label="E(B - V)")

        fig
    end
end
