# Radix-2 Fast Fourier Transform (FFT) in Haskell
A pure functional implementation of the radix-2 Cooley–Tukey FFT algorithm in Haskell, including:

- Recursive radix-2 FFT  
- Naive O(n²) DFT  
- Numerical correctness verification  
- Full mathematical proof in LaTeX  
- Example signal generation  

---

## 📁 Project Structure

```
.
├── Main.hs          -- Haskell implementation (FFT, DFT, verification)
├── fft_proof.tex    -- Mathematical proof (correctness + complexity)
└── README.md        -- Project documentation
```

---

## 🚀 Features

### ✔️ Radix-2 Recursive FFT  
Splits into evens/odds → recursive FFTs → twiddle multiplication → recombination.

### ✔️ Naive DFT  
Direct implementation of the mathematical formula for correctness checking.

### ✔️ Verification Harness  
Prints FFT results, DFT results, and maximum floating-point error.

### ✔️ Full Mathematical Proof  
Includes decomposition proof, correctness, Master theorem, and n=8 example.

---

## 📦 Requirements

- GHC (Haskell compiler)
- Optional: TeX Live / MiKTeX (for proof PDF)

Check GHC:

```
ghc --version
```

Install GHCup if needed:

```
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
```

---

## 🧪 Running the Program

### Run without compilation:

```
runghc Main.hs
```

Run with custom FFT size:

```
runghc Main.hs 1024
```

### or compile:

```
ghc -O2 Main.hs -o fft
./fft 8
```

---

## 📝 Example Output

```
n = 8
max error (fft vs dft) = 2.220446049250313e-16
first 8 outputs (FFT):
 0: ...
 ...
first 8 outputs (DFT):
 0: ...
 ...
```

---

## 🔍 Algorithm Summary

Given evens = FFT(x₀, x₂, …) and odds = FFT(x₁, x₃, …):

```
X_k       = E_k + ω_n^k O_k
X_{k+n/2} = E_k - ω_n^k O_k
```

This leads to the classic complexity:

```
T(n) = 2T(n/2) + O(n) = O(n log n)
```

---

## 📘 Mathematical Proof

Found in:

```
Mathematical Proof.pdf
```

---

## 🔧 Future Work

- Add IFFT (inverse FFT)  
- Replace lists with `Data.Vector`  
- In-place iterative FFT  
- Spectrum visualization tools  

---

## 📄 License

Free to use for academic or educational purposes.

