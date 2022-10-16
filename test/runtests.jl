using DeDisp
using Test

@testset "DeDisp.jl" begin
    @testset "Testing Δt" begin
        @test Δt(1.0, 1.0, 1.0) == 0.0
        @test Δt(1.0, 2.0, 1.0) == 𝓓 * (1 - 1/4)
        @test Δt(2.0, 1.0, 1.0) == 𝓓 * (1/4 - 1)
        @test Δt(2.0, 1.0, 2.0) == 𝓓 * 2 * (1/4 - 1)
    end

    @testset "Testing Δξ!" begin
        dummy = zeros(Int64, 10)
        @test all(DeDisp.Δξ!(dummy, 0.0, 0.0, 10, 2, 2, 0.0) .== 0.0)
        @test all(DeDisp.Δξ!(dummy, 1.0, 0.0, 10, 2, 2, 0.0) .== 0.0)
        @test all(DeDisp.Δξ!(dummy, 1.0, 1.0, 10, 3, 2, 1.0) .== 0.0)
        @test all(DeDisp.Δξ!(dummy, 1.0, 0.0, 10, 2, 2, 0.0) .== 0.0)
    end
end
