type = typeof
echo = Base.print
print = println
len = length

sin(x) = broadcast(Base.sin, x)
+(x...) = broadcast(Base.:+, x...)
-(x...) = broadcast(Base.:-, x...)


posidx(A, i) = i<0 ? lastindex(A)+1+i : i

function _getindex(A::Array, I::UnitRange{Int})
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

Base.getindex(A::Array, I::UnitRange{Int}) = _getindex(A, I)
Base.getindex(A::Array, i::Int) = Base.arrayref(1, A, posidx(A, i))   # array.jl:801

