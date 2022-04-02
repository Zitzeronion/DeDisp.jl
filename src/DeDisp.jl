module DeDisp

export Δξ
export dd

𝓓()::Float64 = 4.1488064239e3
Δt(f₁, f₂, DM) = 𝓓() * DM * (1/f₁^2 - 1/f₂^2)

function Δξ!(ξ, fₕ, Δf, nf, nt, δt, DM)
    δf = Δf / nf
    f₀ = fₕ + δf
    for i ∈ 1:nf
        f = f₀ - i * δf
        δξ = Δt(f, fₕ, DM) ÷ δt
        ξ[i] = δξ < nt ? δξ : 0
    end
    ξ
end

function Δξ(fₕ, Δf, nf, nt, δt, DM)
    ξ = zeros(Int64, nf)
    Δξ!(ξ, fₕ, Δf, nf, nt, δt, DM)
end

function dditer!(X, I, ξ)
    for j ∈ 1:size(I, 2)
        for i ∈ 1:size(X, 1)
            X[i] += I[CartesianIndex(i + ξ[j], j)]
        end
    end
    X
end

function dd(I, fₕ, Δf, δt, DM)
    nt, nf = size(I)
    ξ = Δξ(fₕ, Δf, nf, nt, δt, DM)
    ξₘ = maximum(ξ)
    nt′ = nt - ξₘ
    X = zeros(eltype(I), nt′)
    dditer!(X, I, ξ)
end

"""
"""
dd

end
