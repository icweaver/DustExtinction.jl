using Plots, LaTeXStrings
import DustExtinction: ccm89_ca, ccm89_cb, od94_ca, od94_cb,
                       # TODO: replace deprecated invum functions
                       ccm89_invum, vcg04_invum, gcc09_invum, m14_invum,
                       f99_invum, f04_invum, f19_invum,
                       CAL00, FM90, G16, SFD98Map,
                       # Kludge until Makie PR merged
                       aa_to_invum

dir = joinpath(@__DIR__, "src", "assets")

#--------------------------------------------------------------------------------
# ccm89

w = range(0.3, 10.0, length=1000)
plot(legend=:topleft)
for rv in [2.0, 3.1, 4.0, 5.0, 6.0]
  m = ccm89_invum.(w, rv, Ref(ccm89_ca), Ref(ccm89_cb))
  plot!(w, m, label="Rv=$rv")
end
xlabel!(L"x\ \left[\mu m ^{-1}\right]")
ylabel!(L"A(x)/A(V)")
savefig(joinpath(dir, "ccm89_plot.svg"))

#--------------------------------------------------------------------------------
# od94

w = range(0.3, 10.0, length=1000)
plot(legend=:topleft)
for rv in [2.0, 3.1, 4.0, 5.0, 6.0]
  m = ccm89_invum.(w, rv, Ref(od94_ca), Ref(od94_cb))
  plot!(w, m, label="Rv=$rv")
end
xlabel!(L"x\ \left[\mu m ^{-1}\right]")
ylabel!(L"A(x)/A(V)")
savefig(joinpath(dir, "od94_plot.svg"))

#--------------------------------------------------------------------------------
# cal00

w = range(0.46, 8.3, length=1000)
plot(legend=:topleft)
for rv in [2.0, 3.0, 4.05, 5.0, 6.0]
  m = CAL00(Rv=rv).(aa_to_invum.(w)) # kludge until Makie
  plot!(w, m, label="Rv=$rv")
end
xlabel!(L"x\ \left[\mu m ^{-1}\right]")
ylabel!(L"A(x)/A(V)")
savefig(joinpath(dir, "cal00_plot.svg"))

#--------------------------------------------------------------------------------
# sfd98

l = range(-pi, pi, length=400)
b = range(-pi/64, pi/64, length=300)
dustmap = SFD98Map()
m = [dustmap(li, bj) for li in l, bj in b]
heatmap(l, b, m, label="", transpose=true, colorbar_title="E(B-V)")
xlabel!("l (rad)")
ylabel!("b (rad)")
savefig(joinpath(dir, "sfd98_plot.svg"))

#--------------------------------------------------------------------------------
# gcc09

w = range(3.3, 11.0, length=1000)
plot(legend=:topleft)
for rv in [2.0, 3.1, 4.0, 5.0, 6.0]
  m = gcc09_invum.(w, rv)
  plot!(w, m, label="Rv=$rv")
end
xlabel!(L"x\ \left[\mu m ^{-1}\right]")
ylabel!(L"A(x)/A(V)")
savefig(joinpath(dir, "gcc09_plot.svg"))

#--------------------------------------------------------------------------------
# vcg04

w = range(3.3, 8.0, length=1000)
plot(legend=:topleft)
for rv in [2.0, 3.1, 4.0, 5.0, 6.0]
  m = vcg04_invum.(w, rv)
  plot!(w, m, label="Rv=$rv")
end
xlabel!(L"x\ \left[\mu m ^{-1}\right]")
ylabel!(L"A(x)/A(V)")
savefig(joinpath(dir, "vcg04_plot.svg"))

#--------------------------------------------------------------------------------
# F99

w = range(0.3, 10.0, length=1000)
plot(legend=:topleft)
for rv in [2.0, 3.1, 4.0, 5.0, 6.0]
  m = f99_invum.(w, rv)
  plot!(w, m, label="Rv=$rv")
end
xlabel!(L"x\ \left[\mu m ^{-1}\right]")
ylabel!(L"A(x)/A(V)")
savefig(joinpath(dir, "F99_plot.svg"))

#--------------------------------------------------------------------------------
# F04

w = range(0.3, 10.0, length=1000)
plot(legend=:topleft)
for rv in [2.0, 3.1, 4.0, 5.0, 6.0]
  m = f04_invum.(w, rv)
  plot!(w, m, label="Rv=$rv")
end
xlabel!(L"x\ \left[\mu m ^{-1}\right]")
ylabel!(L"A(x)/A(V)")
savefig(joinpath(dir, "F04_plot.svg"))

#--------------------------------------------------------------------------------
# F19

w = range(0.3, 8.7, length=1000)
plot(legend=:topleft)
for rv in [2.0, 3.1, 4.0, 5.0, 6.0]
  m = f19_invum.(w, rv)
  plot!(w, m, label="Rv=$rv")
end
xlabel!(L"x\ \left[\mu m ^{-1}\right]")
ylabel!(L"A(x)/A(V)")
savefig(joinpath(dir, "F19_plot.svg"))

#--------------------------------------------------------------------------------
# M14

w = range(0.3, 3.3, length=1000)
plot(legend=:topleft)
for rv in [2.0, 3.1, 4.0, 5.0, 6.0]
  m = m14_invum.(w, rv)
  plot!(w, m, label="Rv=$rv")
end
xlabel!(L"x\ \left[\mu m ^{-1}\right]")
ylabel!(L"A(x)/A(V)")
savefig(joinpath(dir, "M14_plot.svg"))

#--------------------------------------------------------------------------------
# FM90

w = range(3.8, 8.6, step = 0.001)
x = 1e4 ./ w
plot(legend=:top)

m1 = FM90().(x)
plot!(w, m1, label = "total")

m2 = FM90(c3=0.0, c4=0.0).(x)
plot!(w, m2, label = "linear term")

m3 = FM90(c1=0.0, c2=0.0, c4=0.0).(x)
plot!(w, m3, label = "bump term")

m4 = FM90(c1=0.0, c2=0.0, c3=0.0).(x)
plot!(w, m4, label = "FUV rise term")

xlabel!(L"x\ \left[\mu m ^{-1}\right]")
ylabel!(L"E(x - V)/E(B - V)")
savefig(joinpath(dir, "FM90_plot.svg"))

#--------------------------------------------------------------------------------
# G16

# Fixed f_A = 1.0, variable Rv
w = range(0.3, 10.0, length=1000)
x = 1e4 ./ w
plot()
for rv in [2.0, 3.1, 4.0, 5.0, 6.0]
  m = G16(Rv=rv, f_A=1.0).(x)
  plot!(w, m, label="Rv=$rv", legendtitle="f_A = 1.0", legend=:topleft)
end
xlabel!(L"x\ \left[\mu m ^{-1}\right]")
ylabel!(L"A(x)/A(V)")
savefig(joinpath(dir, "G16_fixed_f_A_plot.svg"))

# Fixed Rv = 3.1, variable f_A
plot()
for f_A in [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]
  m = G16(Rv=3.1, f_A=f_A).(x)
  plot!(w, m, label="f_A=$f_A", legendtitle="Rv = 3.1", legend=:topleft)
end
xlabel!(L"x\ \left[\mu m ^{-1}\right]")
ylabel!(L"A(x)/A(V)")
savefig(joinpath(dir, "G16_fixed_Rv_plot.svg"))
