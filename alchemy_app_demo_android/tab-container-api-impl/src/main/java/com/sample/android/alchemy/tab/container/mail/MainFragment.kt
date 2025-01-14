package com.sample.android.alchemy.tab.container.mail

import android.os.Bundle
import android.view.View
import com.sample.android.alchemy.common.ui.utils.NotAvailableToast
import com.sample.android.alchemy.common.ui.base.BaseBindingFragment
import com.sample.android.alchemy.tab.container.R
import com.sample.android.alchemy.tab.container.databinding.AlchemySampleFragmentMailBinding
import com.sample.android.alchemy.tab.container.mail.bean.MailBean

class MainFragment :
    BaseBindingFragment<AlchemySampleFragmentMailBinding>(AlchemySampleFragmentMailBinding::inflate) {

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)

        childFragmentManager
            .beginTransaction()
            .add(R.id.container, MailListFragment { _, item ->
                navToMailDetailActivity(item)
            })
            .commitNow()

        initTitleView()
        initDrawer()
    }

    private fun navToMailDetailActivity(mailBean: MailBean) {
        MailDetailActivity.launch(requireContext(), mailBean.title, mailBean.content)
    }

    private fun initDrawer() {
        binding.drawer.let {
            it.inboxFrame.setOnClickListener(drawerItemNoopOnClickListener)
            it.flaggedFrame.setOnClickListener(drawerItemNoopOnClickListener)
            it.draftsFrame.setOnClickListener(drawerItemNoopOnClickListener)
            it.sentFrame.setOnClickListener(drawerItemNoopOnClickListener)
            it.trashFrame.setOnClickListener(drawerItemNoopOnClickListener)
            it.spamFrame.setOnClickListener(drawerItemNoopOnClickListener)
            it.composeFrame.setOnClickListener(drawerItemNoopOnClickListener)
        }
    }

    private val drawerItemNoopOnClickListener = View.OnClickListener {
        NotAvailableToast.show(requireContext())
        binding.drawerLayout.close()
    }

    private fun initTitleView() {
        binding.menuFrame.let {
            it.setOnClickListener {
                if (binding.drawerLayout.isOpen) {
                    binding.drawerLayout.close()
                } else {
                    binding.drawerLayout.open()
                }
            }
        }
        binding.titleEdit.let {
            it.setOnClickListener {
                NotAvailableToast.show(requireContext())
            }
        }
    }
}