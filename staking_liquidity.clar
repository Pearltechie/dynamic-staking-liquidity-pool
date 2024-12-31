(define-map liquidity-pool (principal) (uint)) ; Track liquidity deposited by users
(define-map staking-rewards (principal) (uint)) ; Track rewards accumulated by users
(define-var total-staked uint) ; Track the total liquidity staked in the pool

(define-public (deposit-liquidity (amount uint))
  (let ((user (get-caller)))
    (begin
      ;; Add the deposited liquidity to the user's account
      (map-set liquidity-pool user amount)
      ;; Increase the total liquidity staked
      (set total-staked (+ total-staked amount))
      (ok "Liquidity deposited successfully!")))

(define-public (claim-rewards)
  (let ((user (get-caller)))
    (let ((user-liquidity (map-get? liquidity-pool user)))
      (match user-liquidity
        (some liquidity)
          ;; Calculate rewards based on the liquidity staked
          (let ((rewards (* liquidity 0.1))) ; Rewards are 10% of liquidity staked
            (begin
              ;; Add rewards to the user's balance
              (map-set staking-rewards user rewards)
              (ok (str "Rewards claimed: " (as-string rewards)))))
        (err "No liquidity staked!"))))

(define-public (get-staked-balance)
  (let ((user (get-caller)))
    (match (map-get? liquidity-pool user)
      (some balance) (ok (str "Staked liquidity: " (as-string balance)))
      (err "No liquidity staked!"))))

(define-public (get-total-staked)
  (ok (str "Total liquidity staked: " (as-string total-staked))))
