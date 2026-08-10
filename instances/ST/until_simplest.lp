%*
metasp solve flingo --meta-config config.yaml \
                    --warn=no-atom-undefined \
                    instances/ST/until_simpliest.lp  0 \
                    -c display_time=7  \
                    --project=show \
                    -c n=10
*%



&until(p, q).  % PROB: support allows points to jump to a same place. 






