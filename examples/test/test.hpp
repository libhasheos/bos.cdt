#include <eosiolib/eosio.hpp>
#include <eosiolib/time.hpp>
//#include <eosiolib/types.h>
using namespace eosio;

CONTRACT test : public eosio::contract {
  public:
      using contract::contract;

        struct args{
            uint64_t loop;
            uint64_t num;
        };
        ACTION generate(const args& t);

        ACTION clear();

        struct args_name{
            name name_;
        };

        ACTION hascontract(const args_name& t);

        struct args_inline{
            name payer;
            name in;
        };
        ACTION inlineact(const args_inline& t);

public:
        TABLE seedobj {
            uint64_t    id;
            time_point  create;
            std::string seedstr;
            std::string txid;
            uint64_t    action;

            uint64_t primary_key()const { return id; }
            EOSLIB_SERIALIZE(seedobj,(id)(create)(seedstr)(txid)(action))
        };
        typedef eosio::multi_index< "seedobjs"_n, seedobj> seedobjs;
};
