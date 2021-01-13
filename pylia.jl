posidx(A, i) = i<0 ? lastindex(A)+1+i : i

function getindexs(A::Array, I::UnitRange{Int})
    I = UnitRange(posidx(A, I.start), posidx(A, I.stop))
    @Base._inline_meta
    @boundscheck checkbounds(A, I)
    lI = length(I)
    X = similar(A, lI)
    if lI > 0
        unsafe_copyto!(X, 1, A, first(I), lI)
    end
    return X
end

Base.getindex(A::Array, I::UnitRange{Int}) = getindexs(A, I)
Base.getindex(A::Array, i::Int) = Base.arrayref(1, A, posidx(A, i)) # 801 array.jl

A = [1 2 3 4 5 6 7] * 10

println(A[-5:-2])
println(A[-4])
